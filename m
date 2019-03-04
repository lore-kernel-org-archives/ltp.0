From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 4 Mar 2019 14:36:09 +0100
Subject: [LTP] Question regarding background jobs in LTP
In-Reply-To: <0AAF7904-0F33-4D6C-949E-4733722BE46B@linux.vnet.ibm.com>
References: <AD78C4C6-E57B-4E67-91CC-EFD43E8CE99E@linux.vnet.ibm.com>
 <20190301114953.GA32413@rei.lan>
 <0AAF7904-0F33-4D6C-949E-4733722BE46B@linux.vnet.ibm.com>
Message-ID: <20190304133609.GB27682@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> We've tried  "#/bin/sh -x" didn't changed the output
> it hangs on the same command:
> 
> mon_fsstatd 1 TPASS: 'mon_procd --version' returned '0'
> mon_fsstatd 1 TPASS: 'mon_procd -i 30' returned '0'
> mon_fsstatd 1 TBROK: test killed, timeout!
> the command which lead to the hang - is the same:
> 
> mon_fsstatd_run 0 "mon_procd -a &???

Now I see the problem, you cannot pass a string to a function, execute
the variable holding the string, and expect bash to parse special
characters in the string, as it is the & is passed as a parameter to the
mon_procd instead because the string is not broken down.

-- 
Cyril Hrubis
chrubis@suse.cz
