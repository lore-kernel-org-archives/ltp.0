From: Mimi Zohar <zohar@linux.ibm.com>
Date: Wed, 24 Jun 2020 16:02:43 -0400
Subject: [LTP] [PATCH v3 2/2] IMA: Add a test to verify importing a
 certificate into keyring
In-Reply-To: <20418d14-d464-ec09-e1f2-c1b96e9df5f6@linux.microsoft.com>
References: <20200617234957.10611-1-t-josne@linux.microsoft.com>
 <20200617234957.10611-3-t-josne@linux.microsoft.com>
 <1593016868.27152.88.camel@linux.ibm.com>
 <20418d14-d464-ec09-e1f2-c1b96e9df5f6@linux.microsoft.com>
Message-ID: <1593028963.27152.153.camel@linux.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, 2020-06-24 at 15:59 -0400, Lachlan Sneff wrote:
> 
> >> diff --git a/testcases/kernel/security/integrity/ima/README.md b/testcases/kernel/security/integrity/ima/README.md
> >> index 16a1f48c3..e41f7b570 100644
> >> --- a/testcases/kernel/security/integrity/ima/README.md
> >> +++ b/testcases/kernel/security/integrity/ima/README.md
> >> @@ -16,6 +16,27 @@ CONFIG_INTEGRITY=y
> >>   CONFIG_IMA=y
> >>   ```
> >>   
> >> +IMA Key Import test
> >> +-------------
> >> +
> >> +`ima_keys.sh` requires an x509 key to be generated and placed
> >> +at `/etc/keys/x509_ima.der`.
> > The filename "/etc/keys/x509_ima.der" is configurable. ?It's based on
> > CONFIG_IMA_X509_PATH Kconfig option. ?Perhaps extract it from the
> > running kernel's Kconfig?
> I didn't think pulling it from the kernel config. Will try this. I 
> assume `grep "..." /boot/config-$(uname -r)` is the right way to grab a 
> line from the config?

Try using scripts/extract-ikconfig.

Mimi

