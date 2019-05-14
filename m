From: Ignaz Forster <iforster@suse.de>
Date: Tue, 14 May 2019 21:19:04 +0200
Subject: [LTP] [PATCH v2 0/3] LTP reproducer on broken IMA on overlayfs
In-Reply-To: <20190514121213.GA28655@dell5510>
References: <20190405165225.27216-1-pvorel@suse.cz>
 <20190514121213.GA28655@dell5510>
Message-ID: <bf41c3b5-baf4-ba7a-2136-dabbbb817473@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

Am 14.05.19 um 14:12 Uhr schrieb Petr Vorel:
> Could you, please, share your setup?

The system was installed with IMA and EVM enabled during installation, 
using the following kernel parameters:
"ima_policy=appraise_tcb ima_appraise=fix evm=fix"

The EVM key was generated in the live system before starting the actual 
installation and copied into the installed system later.

See the attached installation notes for an openSUSE system (which should 
also be usable on other distributions).

> ima_policy=appraise_tcb kernel parameter and loading IMA and EVM keys over
> dracut-ima scripts?

Exactly.

> (IMA appraisal and EVM using digital signatures? I guess
> using hashes for IMA appraisal would work as well).

I focused on hashes, as those are more relevant for the overlayfs use 
case I was thinking of.

Ignaz
-------------- next part --------------
Manual IMA / EVM installation:
* Use a net install image (some of the necessary packages are not available in DVD image)
* Boot install system with "ima_policy=appraise_tcb ima_appraise=fix evm=fix" (for IMA measurement, IMA appraisal and EVM protection)
* Proceed with installation until summary screen, but do not start the installation yet
* Remove "evm=fix" from kernel boot parameters
* Change kernel boot parameter "ima_appraise=fix" to "ima_appraise=appraise_tcb"
* Select package "dracut-ima" (required for early boot EVM support) for installation
* Change to a console window
* mkdir /etc/keys
* /bin/keyctl add user kmk-user "`dd if=/dev/urandom bs=1 count=32 2>/dev/null`" @u
* /bin/keyctl pipe `/bin/keyctl search @u user kmk-user` > /etc/keys/kmk-user.blob
* /bin/keyctl add encrypted evm-key "new user:kmk-user 64" @u
* /bin/keyctl pipe `/bin/keyctl search @u encrypted evm-key` >/etc/keys/evm.blob
* cat <<END >/etc/sysconfig/masterkey
MASTERKEYTYPE="user"
MASTERKEY="/etc/keys/kmk-user.blob"
END
* cat <<END >/etc/sysconfig/evm
EVMKEY="/etc/keys/evm.blob"
END
* mount -t securityfs security /sys/kernel/security
* echo 1 >/sys/kernel/security/evm
* Go back to the installation summary screen and start the installation
* During the installation execute the following commands from the console:
* cp -r /etc/keys /mnt/etc/
* cp /etc/sysconfig/{evm,masterkey} /mnt/etc/sysconfig/
