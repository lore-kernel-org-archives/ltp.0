From: Lachlan Sneff <t-josne@linux.microsoft.com>
Date: Mon,  3 Aug 2020 14:47:24 -0400
Subject: [LTP] [PATCH 1/3] IMA: Update key test documentation
In-Reply-To: <20200803184726.2416-1-t-josne@linux.microsoft.com>
References: <20200803184726.2416-1-t-josne@linux.microsoft.com>
Message-ID: <20200803184726.2416-2-t-josne@linux.microsoft.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The current documentation for the existing IMA key test was
left in by accident by a previous merge. It does not apply
to the test that is currently included in the LTP.

Update the documentation for the IMA key test.

Signed-off-by: Lachlan Sneff <t-josne@linux.microsoft.com>
---
 .../kernel/security/integrity/ima/README.md   | 22 +++++--------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/README.md b/testcases/kernel/security/integrity/ima/README.md
index d4644ba39..2956ac7fd 100644
--- a/testcases/kernel/security/integrity/ima/README.md
+++ b/testcases/kernel/security/integrity/ima/README.md
@@ -15,27 +15,15 @@ Although a custom policy, loaded via dracut, systemd or manually from user
 space, may contain equivalent measurement tcb rules, detecting them would
 require `IMA_READ_POLICY=y` therefore ignore this option.
 
-### IMA key import test
-`ima_keys.sh` requires a x509 public key, by default in `/etc/keys/x509_ima.der`
-(defined in `CONFIG_IMA_X509_PATH` kernel config option).
-The key must be signed by the private key you generate. Follow these instructions:
-https://manpages.ubuntu.com/manpages/disco/man1/evmctl.1.html#generate%20trusted%20keys
-
-The test cannot be set-up automatically because the x509 public key must be
-built into the kernel and loaded onto a trusted keyring
-(e.g. `.builtin_trusted_keys`, `.secondary_trusted_keyring`).
-
-As well as what's required for the IMA tests, the following are also required
-in the kernel configuration:
+### IMA key test
+`ima_keys.sh` requires a readable IMA policy, as well as a loaded policy
+with `func=KEY_CHECK keyrings=...`, see example in `keycheck.policy`.
+
+Mandatory kernel configuration for IMA:
 ```
 CONFIG_IMA_READ_POLICY=y
-CONFIG_IMA_X509_PATH="/etc/keys/x509_ima.der"
-CONFIG_SYSTEM_TRUSTED_KEYRING=y
-CONFIG_SYSTEM_TRUSTED_KEYS="/etc/keys/ima-local-ca.pem"
 ```
 
-Test also requires loaded policy with `func=KEY_CHECK`, see example in `keycheck.policy`.
-
 ### IMA kexec test
 
 `ima_kexec.sh` requires loaded policy which contains `measure func=KEXEC_CMDLINE`,
-- 
2.25.1

