From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Mon, 29 Jan 2018 14:58:23 -0500
Subject: [LTP] [RFC PATCH 0/2] IMA: Rewrite tests into new API + fixes
In-Reply-To: <1517100440.29187.120.camel@linux.vnet.ibm.com>
References: <20180111202821.31639-1-pvorel@suse.cz>
 <1516815417.3686.55.camel@linux.vnet.ibm.com>
 <20180125203057.mzzpilp6i43xftka@dell5510>
 <1516919365.6513.72.camel@linux.vnet.ibm.com>
 <20180126175110.boaepz6dqe3uojq6@dell5510>
 <1517100440.29187.120.camel@linux.vnet.ibm.com>
Message-ID: <1517255903.29187.560.camel@linux.vnet.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

On Sat, 2018-01-27 at 19:47 -0500, Mimi Zohar wrote:
> On Fri, 2018-01-26 at 18:51 +0100, Petr Vorel wrote:


> > > > > Originally IMA allowed a builtin policy to be replaced with a custom
> > > > > policy, by simply cat'ing a file into the securityfs IMA policy file.
> > > > > Currently, if new rules can be added to the custom policy (Kconfig
> > > > > IMA_WRITE_POLICY enabled), the policy file must be signed.  Similarly,
> > > > > if the builtin "secure-boot" policy is defined on the boot command
> > > > > line, the custom policy must be signed.  Test "ima01 ima_policy.sh"
> > > > > should first detect if the policy must be signed, before running the
> > > > > tests.
> > 
> > > > Right, I'll check it. Is there other way how to detect it than reading
> > > > /boot/config-$(uname -r) or /proc/config.gz ? I'm asking because IMA might be using on
> > > > embedded devices (guessing from [2], [3]), which might not have either of them.
> > This is important. As Cyril agreed with me grepping /boot/config-$(uname -r) or
> > /proc/config.gz isn't good solution. I don't see any ioctl interface and
> > security/integrity/ima/ima_fs.c which handles IMA sysfs doesn't have this functionality.
> > Is it deliberate (security reason), that it's not exported to users?
> 
> This isn't really an IMA issue, but a TPM one.  The TPM device driver
> would need to export this information.

Sorry, that was an answer to the wrong question.  In ima_tpm.sh,
there's the question:

# Would be nice to know where the PCRs are located. Is this safe?".

Commit 313d21e "tpm: device class for tpm" moved the TPM sysfs
location from /sys/class/misc/tpmX/device/ to
/sys/class/tpm/tpmX/device/.  The pcrs are 


To answer your question, if after writing the custom policy, the
policy file disappears, then you obviously can't extend the policy.
 If the policy file doesn't disappear, you might not be able to extend
the policy, just view it.  Sorry, there's no method of knowing apriori
whether the policy can be extended.

Mimi

