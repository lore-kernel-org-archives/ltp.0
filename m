From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 14 Jul 2020 14:10:34 +0200
Subject: [LTP] [PATCH v3 2/2] IMA: Add a test to verify importing a
 certificate into keyring
In-Reply-To: <1593028963.27152.153.camel@linux.ibm.com>
References: <20200617234957.10611-1-t-josne@linux.microsoft.com>
 <20200617234957.10611-3-t-josne@linux.microsoft.com>
 <1593016868.27152.88.camel@linux.ibm.com>
 <20418d14-d464-ec09-e1f2-c1b96e9df5f6@linux.microsoft.com>
 <1593028963.27152.153.camel@linux.ibm.com>
Message-ID: <20200714121034.GA8020@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Mimi, Lachlan,

> > >> +`ima_keys.sh` requires an x509 key to be generated and placed
> > >> +at `/etc/keys/x509_ima.der`.
> > > The filename "/etc/keys/x509_ima.der" is configurable. ?It's based on
> > > CONFIG_IMA_X509_PATH Kconfig option. ?Perhaps extract it from the
> > > running kernel's Kconfig?
> > I didn't think pulling it from the kernel config. Will try this. I 
> > assume `grep "..." /boot/config-$(uname -r)` is the right way to grab a 
> > line from the config?

> Try using scripts/extract-ikconfig.
For now I'd just try to grep /boot/config-$(uname -r), but allow to run the test
with the default value if kconfig not presented / readable (when running without
root).

I'm not sure if extract-ikconfig as external dependency would be suitable for
LTP (understand it's great for kselftest as it's already presented).

BTW there is a ticket for adding kernel config related helpers into the LTP
shell API [1], I'll also note extract-ikconfig there.

LTP refused for long time working with kernel config, because it it's
requirement meant that SUT without it could not be tested. Always try to not
make kernel config as hard dependency (various embedded or old android will be
disabled; some linux distros require root for reading the config).
Design in [1] also suggest to have possibility to run the test even without config.

[1] https://github.com/linux-test-project/ltp/issues/700

> Mimi

Kind regards,
Petr
