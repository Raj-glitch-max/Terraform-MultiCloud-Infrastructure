import * as core from "oci-core";
import common = require("oci-common");

const provider: common.ConfigFileAuthenticationDetailsProvider = new common.ConfigFileAuthenticationDetailsProvider();

(async () => {
  try {
    const client = new core.VirtualNetworkClient({ authenticationDetailsProvider: provider });
    const ipsecId = process.argv[2];    
    const tunnelId = process.argv[3];
    const oracleIp = process.argv[4];    
    const customerIp = process.argv[5];

    if (!ipsecId || !tunnelId ||!oracleIp ||!customerIp) {
      console.error("Usage: node script.js <IPSec_ID> <Tunnel_ID> <oracleIp> <customerIp>");
      return;
    }
    const updateIPSecConnectionTunnelDetails = {
      routing: core.models.UpdateIPSecConnectionTunnelDetails.Routing.Bgp,
      ikeVersion: core.models.UpdateIPSecConnectionTunnelDetails.IkeVersion.V2,
      bgpSessionConfig: {
        oracleInterfaceIp: oracleIp,
        customerInterfaceIp: customerIp,
        customerBgpAsn: "65515"
      },
      oracleInitiation:
        core.models.UpdateIPSecConnectionTunnelDetails.OracleInitiation.InitiatorOrResponder,
      natTranslationEnabled:
        core.models.UpdateIPSecConnectionTunnelDetails.NatTranslationEnabled.Auto,
      phaseOneConfig: {
        isCustomPhaseOneConfig: true,
        authenticationAlgorithm: core.models.PhaseOneConfigDetails.AuthenticationAlgorithm.Sha2384,
        encryptionAlgorithm: core.models.PhaseOneConfigDetails.EncryptionAlgorithm.Aes256Cbc,
        diffieHelmanGroup: core.models.PhaseOneConfigDetails.DiffieHelmanGroup.Group2,
        lifetimeInSeconds: 28800
      },
      phaseTwoConfig: {
        isCustomPhaseTwoConfig: true,
        encryptionAlgorithm: core.models.PhaseTwoConfigDetails.EncryptionAlgorithm.Aes256Gcm,
        lifetimeInSeconds: 3600,
        isPfsEnabled: true,
        pfsDhGroup: core.models.PhaseTwoConfigDetails.PfsDhGroup.Group2
      },
      dpdConfig: {
        dpdMode: core.models.DpdConfig.DpdMode.RespondOnly,
        dpdTimeoutInSec: 20
      }
    };

    const updateIPSecConnectionTunnelRequest: core.requests.UpdateIPSecConnectionTunnelRequest = {
      ipscId: ipsecId,
      tunnelId: tunnelId,
      updateIPSecConnectionTunnelDetails: updateIPSecConnectionTunnelDetails,
    };

    const updateIPSecConnectionTunnelResponse = await client.updateIPSecConnectionTunnel(
      updateIPSecConnectionTunnelRequest
    );

  } catch (error) {
    console.log("updateIPSecConnectionTunnel Failed with error  " + error);
  }
})();