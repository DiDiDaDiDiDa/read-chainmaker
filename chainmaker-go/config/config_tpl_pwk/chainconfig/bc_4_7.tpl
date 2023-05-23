#
# Copyright (C) BABEC. All rights reserved.
# Copyright (C) THL A29 Limited, a Tencent company. All rights reserved.
#
# SPDX-License-Identifier: Apache-2.0
#

# This file is used to generate genesis block.
# The content should be consistent across all nodes in this chain.

# chain id
chain_id: {chain_id}

# chain maker version
version: {version}

# chain config sequence
sequence: 0

# The blockchain auth type, shoudle be consistent with auth type in node config (e.g., chainmaker.yml)
# The auth type can be permissionedWithCert, permissionedWithKey, public.
# By default it is permissionedWithCert.
# permissionedWithCert: permissioned blockchain, using x.509 certificate to identify members.
# permissionedWithKey: permissioned blockchain, using public key to identify members.
# public: public blockchain, using public key to identify members.
auth_type: "permissionedWithKey"

# Crypto settings
crypto:
  # Hash algorithm, can be SHA256, SHA3_256 and SM3
  hash: {hash_type}

# User contract related settings
contract:
  # If the sql support contract is enabled or not.
  # If it is true, storage.statedb_config.provider in chainmaker.yml should be sql.
  enable_sql_support: false

# Virtual machine related settings
vm:
  #0:chainmaker, 1:zxl, 2:ethereum
  addr_type: 2
  # support vm list
  support_list:
    - "wasmer"
    - "gasm"
    - "evm"
    - "dockergo"
    - "wxvm"
  native:
      multisign:
        enable_manual_run: true

# Block proposing related settings
block:
  # To enable this attribute, ensure that the clock of the node is consistent
  # Verify the transaction timestamp or not
  tx_timestamp_verify: true

  # Transaction timeout, in second.
  # if abs(now - tx_timestamp) > tx_timeout, the transaction is invalid.
  tx_timeout: 600

  # Max transaction count in a block.
  block_tx_capacity: 100

  # Max block size, in MB
  block_size: 10

  # The interval of block proposing attempts, in millisecond.
  # should be within the range of [10,10000]
  block_interval: 10

# Core settings
core:
  # Max scheduling time of a block, in second.
  # [0, 60]
  tx_scheduler_timeout: 10

  # Max validating time of a block, in second.
  # [0, 60]
  tx_scheduler_validate_timeout: 10

  # Used for handling txs with sender conflicts efficiently
  enable_sender_group: false

  # Used for dynamic tuning the capacity of tx execution goroutine pool
  enable_conflicts_bit_window: true

  # Consensus message compression related settings
  # consensus_turbo_config:
    # If consensus message compression is enabled or not(solo could not use consensus message turbo).
    # consensus_message_turbo: false

    # Max retry count of fetching transaction in txpool by txid.
    # retry_time: 500

    # Retry interval of fetching transaction in txpool by txid, in ms.
    # retry_interval: 20

# snapshot settings
# snapshot:
  # Enable the evidence snapshot or not.
  # enable_evidence: false

# scheduler settings
# scheduler:
  # Enable the evidence scheduler or not.
  # enable_evidence: false

# Consensus settings
consensus:
  # Consensus type
  # 0-SOLO, 1-TBFT, 3-MAXBFT, 4-RAFT, 5-DPOS, 6-ABFT
  type: {consensus_type}

  # Consensus node list
  nodes:
    # Each org has one or more consensus nodes.
    # We use p2p node id to represent nodes here.
    - org_id: "{org1_id}"
      node_id:
        - "{org1_peerid}"
    - org_id: "{org2_id}"
      node_id:
        - "{org2_peerid}"
    - org_id: "{org3_id}"
      node_id:
        - "{org3_peerid}"
    - org_id: "{org4_id}"
      node_id:
        - "{org4_peerid}"
#    - org_id: "{org5_id}"
#      node_id:
#        - "{org5_peerid}"
#    - org_id: "{org6_id}"
#      node_id:
#        - "{org6_peerid}"
#    - org_id: "{org7_id}"
#      node_id:
#        - "{org7_peerid}"
  # We can specify other consensus config here in key-value format.
  ext_config:
    # - key: aa
    #   value: chain01_ext11

# Trust roots is used to specify the organizations' root certificates in permessionedWithCert mode.
# When in permessionedWithKey mode or public mode, it represents the admin users.
trust_roots:
  # trust roots list start
  # org id and root file path list.
  - org_id: "{org1_id}"
    root:
      - "../config/{org_path}/keys/admin/{org1_id}/admin.pem"
  - org_id: "{org2_id}"
    root:
      - "../config/{org_path}/keys/admin/{org2_id}/admin.pem"
  - org_id: "{org3_id}"
    root:
      - "../config/{org_path}/keys/admin/{org3_id}/admin.pem"
  - org_id: "{org4_id}"
    root:
      - "../config/{org_path}/keys/admin/{org4_id}/admin.pem"
#  - org_id: "{org5_id}"
#    root:
#      - "../config/{org_path}/keys/admin/{org5_id}/admin.pem"
#  - org_id: "{org6_id}"
#    root:
#      - "../config/{org_path}/keys/admin/{org6_id}/admin.pem"
#  - org_id: "{org7_id}"
#    root:
#      - "../config/{org_path}/keys/admin/{org7_id}/admin.pem"
# trust roots list end

# Resource policies settings
resource_policies:
  - resource_name: CHAIN_CONFIG-NODE_ID_UPDATE
    policy:
      # Rule can be Any, All, Majority, Self...
      rule: SELF
      # The org id list, all organizations are need if here is null.
      org_list:
      # The role list
      role_list:
        - admin
  - resource_name: CHAIN_CONFIG-TRUST_ROOT_ADD
    policy:
      rule: MAJORITY
      org_list:
      role_list:
        - admin
  - resource_name: CHAIN_CONFIG-CERTS_FREEZE
    policy:
      rule: ANY
      org_list:
      role_list:
        - admin
  - resource_name: CONTRACT_MANAGE-INIT_CONTRACT
    policy:
      rule: ANY
      org_list:
      role_list:

# The disabled native contract list
# Disable the system contract by specifying the system contract name
# Can disabled native contract name contains CHAIN_CONFIG, CHAIN_QUERY, CERT_MANAGE, GOVERNANCE, MULTI_SIGN, PRIVATE_COMPUTE, DPOS_ERC20, DPOS_STAKE, CROSS_TRANSACTION, PUBKEY_MANAGE
disabled_native_contract:
# - CONTRACT_NAME