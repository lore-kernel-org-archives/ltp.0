From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 23 Feb 2021 23:59:28 +0100
Subject: [LTP] [PATCH v3 0/2]	IMA: Add test for dm-crypt measurement
Message-ID: <20210223225930.27095-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!

I updated Tushar's patchset to speedup things.

Changes v2->v3
* rename function s/check_ima_ascii_log_for_policy/test_policy_measurement/
* move tst_res TPASS/TFAIL into test_policy_measurement()
* drop template=ima-buf (see Lakshmi's patch [1] and discussion about
  it, it will be removed from ima_keys.sh as well)
* moved ima_dm_crypt.sh specific changes to second commit
* further API and style related cleanup

Could you please check this patchset?

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/project/ltp/patch/20210222023421.12576-1-nramas@linux.microsoft.com/

Tushar Sugandhi (2):
  IMA: Generalize key measurement tests
  IMA: Add test for dm-crypt measurement

 runtest/ima                                   |  1 +
 .../kernel/security/integrity/ima/README.md   | 20 ++++++
 .../integrity/ima/tests/ima_dm_crypt.sh       | 41 +++++++++++
 .../security/integrity/ima/tests/ima_keys.sh  | 58 ++-------------
 .../security/integrity/ima/tests/ima_setup.sh | 71 +++++++++++++++++++
 5 files changed, 139 insertions(+), 52 deletions(-)
 create mode 100755 testcases/kernel/security/integrity/ima/tests/ima_dm_crypt.sh

-- 
2.30.1

