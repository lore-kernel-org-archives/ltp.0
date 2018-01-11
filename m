From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 11 Jan 2018 21:28:19 +0100
Subject: [LTP] [RFC PATCH 0/2] IMA: Rewrite tests into new API + fixes
Message-ID: <20180111202821.31639-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

I rewrote IMA tests to use new API + add small fixes.
I haven't tested ima_tpm.sh as I have no TPM :-(.

Comments are welcomed.

Kind regards,
Petr

Petr Vorel (2):
  security/ima: Rewrite tests into new API + fixes
  security/ima: Run measurements after policy

 runtest/ima                                        |   8 +-
 .../integrity/ima/tests/ima_measurements.sh        | 182 +++++++-----------
 .../security/integrity/ima/tests/ima_policy.sh     | 145 +++++++-------
 .../security/integrity/ima/tests/ima_setup.sh      | 109 +++++------
 .../kernel/security/integrity/ima/tests/ima_tpm.sh | 129 ++++++-------
 .../security/integrity/ima/tests/ima_violations.sh | 214 ++++++++++-----------
 6 files changed, 337 insertions(+), 450 deletions(-)
 mode change 100755 => 100644 testcases/kernel/security/integrity/ima/tests/ima_setup.sh

-- 
2.15.1

