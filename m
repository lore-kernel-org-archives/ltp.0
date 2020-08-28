From: Mimi Zohar <zohar@linux.ibm.com>
Date: Fri, 28 Aug 2020 07:19:34 -0400
Subject: [LTP] [LTP v4 4/5] IMA: Add a test to verify measurement of
 certificate imported into a keyring
In-Reply-To: <20200828060554.GB15251@dell5510>
References: <20200820090824.3033-1-pvorel@suse.cz>
 <20200820090824.3033-5-pvorel@suse.cz>
 <b58057275ecdc06bb512d39ea46118197f33c33f.camel@linux.ibm.com>
 <20200827132354.GA20439@dell5510> <20200827135503.GA11990@dell5510>
 <b72657042d13f9b8f30d5bdea7e2d06835e4a1d1.camel@linux.ibm.com>
 <20200827225417.GA29921@dell5510>
 <d6087ee43d18605ee6cdc6b80450b0024af14fb6.camel@linux.ibm.com>
 <20200828060554.GB15251@dell5510>
Message-ID: <3c720a7060a846088f8e60ce8b5c032467e97f23.camel@linux.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, 2020-08-28 at 08:05 +0200, Petr Vorel wrote:
> BTW there are also plans for reboot support [1] [2], that could be used as
> workaround for configuration without CONFIG_IMA_READ_POLICY=y and
> CONFIG_IMA_WRITE_POLICY=y.

The reboot support could also be used for carrying the IMA measurement
list across kexec and verifying the TPM PCRs.

Mimi

