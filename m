From: Joerg Vehlow <lkml@jv-coder.de>
Date: Thu, 2 Sep 2021 16:01:48 +0200
Subject: [LTP] [PATCH 0/4] checkbashisms.pl in make check + fixed docs
In-Reply-To: <20210902103740.19446-1-pvorel@suse.cz>
References: <20210902103740.19446-1-pvorel@suse.cz>
Message-ID: <015140e9-0eba-4057-4a91-35d958af2bb8@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi

one general question about this: How to we want to handle false-positives?

e.g.:

$ checkbashisms testcases/kernel/controllers/memcg/functional/memcg_lib.sh
possible bashism in 
testcases/kernel/controllers/memcg/functional/memcg_lib.sh line 387 
('((' should be '$(('):
 ??????? local limit_down=$(( PAGESIZE * ((limit + PAGESIZE - 1) / 
PAGESIZE) ))

This is obviously a false positive, but could probably be adding a space 
between the brackets.

or

$ checkbashisms testcases/kernel/connectors/pec/cn_pec.sh
possible bashism in testcases/kernel/connectors/pec/cn_pec.sh line 127 
(should be >word 2>&1):
 ??????????????? done <&${fd_act}

This one is just a false positive and I have no clue how to prevent this.
I think the script does not like the <&, but this is posix...

Joerg
