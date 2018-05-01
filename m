From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 1 May 2018 16:02:54 +0200
Subject: [LTP] [COMMITTED] [PATCH 1/1] ima/ima_measurements.sh: Add info
 about tests expecting tcb policy
In-Reply-To: <1524836783.3416.57.camel@linux.vnet.ibm.com>
References: <20180427134333.29017-1-pvorel@suse.cz>
 <1524836783.3416.57.camel@linux.vnet.ibm.com>
Message-ID: <20180501140254.GA32731@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Mimi,

> > +	tst_res TINFO "IMA measurement tests assume tcb policy to be loaded (ima_policy=tbc)"
> ^tcb
Thanks for reporting, fixed.


Kind regards,
Petr
