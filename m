From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Wed, 24 Jan 2018 12:36:57 -0500
Subject: [LTP] [RFC PATCH 0/2] IMA: Rewrite tests into new API + fixes
In-Reply-To: <20180111202821.31639-1-pvorel@suse.cz>
References: <20180111202821.31639-1-pvorel@suse.cz>
Message-ID: <1516815417.3686.55.camel@linux.vnet.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi Petr,

[Cc'ing Roberto]

On Thu, 2018-01-11 at 21:28 +0100, Petr Vorel wrote:
> Hi,
> 
> I rewrote IMA tests to use new API + add small fixes.
> I haven't tested ima_tpm.sh as I have no TPM :-(.
> 
> Comments are welcomed.

The LTP tests are quite dated, and need some major rework.  I really
appreciate your addressing some of the issues.  Below are some
additional ones.

Tests "ima02 ima_measurement.sh" and "ima04 ima_violations.sh" assume
files are created on a filesystem in policy.  The "measure.policy"
excludes tmpfs, yet TMPDIR defaults to a tmpfs filesystem.  There are
a couple of ways of resolving this problem (eg. removing tmpfs from
the "measure.policy", use a RAM block device instead of tmpfs, etc).
 Since the builtin "ima_policy=tcb" also excludes tmpfs, not using a
tmpfs filesystem would be preferable.

Originally IMA allowed a builtin policy to be replaced with a custom
policy, by simply cat'ing a file into the securityfs IMA policy file.
Currently, if new rules can be added to the custom policy (Kconfig
IMA_WRITE_POLICY enabled), the policy file must be signed.  Similarly,
if the builtin "secure-boot" policy is defined on the boot command
line, the custom policy must be signed.  Test "ima01 ima_policy.sh"
should first detect if the policy must be signed, before running the
tests.

ima_boot_aggregate.c defines the BIOS MAX_EVENT_SIZE BIOS size as 500,
but I'm currently seeing BIOS events larger than 4k.

Since these tests were first written, Roberto's IMA templates and
Dmitry's support for larger digests were upstreamed.  With the new
template format, the file hash is prefixed with the hash algorithm.
 Before comparing the calculated boot aggregate with the value in the
IMA measurement list, the hash algorithm needs to be removed.
 
For the new template format measurement lists, walking the measurement
list, re-calculating the PCRs and comparing them with the HW or vTPM
PCRs fail.  The ima-evm-utils package has a working version.  Invoke
"evmctl" with the "ima_mesaurement" option.

thanks,

Mimi

