From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 17 May 2019 17:04:56 +0200
Subject: [LTP] [PATCH] ima: skip verifying TPM 2.0 PCR values
In-Reply-To: <fccc3abd-f3ce-fdb1-55d7-c18ce116446c@linux.vnet.ibm.com>
References: <1558041162.3971.2.camel@linux.ibm.com>
 <fccc3abd-f3ce-fdb1-55d7-c18ce116446c@linux.vnet.ibm.com>
Message-ID: <20190517150456.GA11796@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi Nayna,

...
> > +	local tpm_description="/sys/class/tpm/tpm0/device/description"
...

> I do not see a "description" file on either my PowerPC or x86 systems with
> TPM 2.0.  Perhaps instead of testing for the "description" file, if the
> "pcrs" file is not found, emit a more verbose informational message, for eg.
> - "pcrs file is not found - either you are running a TPM 2.0, or having
> sysfs failed to show pcrs for TPM 1.2"
Some people are using /sys/class/tpm/tpm0/device/description [1] for testing TPM
version. From the discussion on [1] I also got an expression that the file is
not always presented. If there is really no reliable way to detect TPM version
from sysfs (huh!) your approach would make sense for me.

> Thanks & Regards,
>       - Nayna

Kind regards,
Petr

[1] https://github.com/tpm2-software/tpm2-tools/issues/604
