From: Mimi Zohar <zohar@linux.ibm.com>
Date: Tue, 23 Feb 2021 19:43:46 -0500
Subject: [LTP] [PATCH v3 0/2]	IMA: Add test for dm-crypt measurement
In-Reply-To: <20210223225930.27095-1-pvorel@suse.cz>
References: <20210223225930.27095-1-pvorel@suse.cz>
Message-ID: <0a25f4b7ed53566b13211d5aeea18e7f13f12bd7.camel@linux.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

On Tue, 2021-02-23 at 23:59 +0100, Petr Vorel wrote:
> Hi!
> 
> I updated Tushar's patchset to speedup things.
> 
> Changes v2->v3
> * rename function s/check_ima_ascii_log_for_policy/test_policy_measurement/
> * move tst_res TPASS/TFAIL into test_policy_measurement()
> * drop template=ima-buf (see Lakshmi's patch [1] and discussion about
>   it, it will be removed from ima_keys.sh as well)
> * moved ima_dm_crypt.sh specific changes to second commit
> * further API and style related cleanup
> 
> Could you please check this patchset?

I'm not sure about the status of the associated IMA dm-crypt kernel
patch set.  It hasn't even been reviewed, definitely not upstreamed.  
 I would hold off on upstreaming the associated ltp test.

thanks,

Mimi

