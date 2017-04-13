From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 13 Apr 2017 11:41:16 +0200
Subject: [LTP] non-ascii output from mtest01?
In-Reply-To: <201704122004.v3CK40ZR008345@sellcey-dt.caveonetworks.com>
References: <201704122004.v3CK40ZR008345@sellcey-dt.caveonetworks.com>
Message-ID: <20170413094116.GB29761@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I was wondering if anyone else has the test mtest01 printing
> out non-ascii characters.  Attached is the output from my LTP run and I
> always have issues with grepping or reading the output in an editor
> because of these non-ascii characters.

Looks like I've managed to reproduce the issue with:

./mtest01 -p80 |tee out

> I looked at testcases/kernel/mem/mtest01/mtest01.c but I didn't see any
> obvious source for where this output is coming from.

This is memory corruption since we do not check that max_pids is large
enough in the while loops that store pids into pid_list[i] array and it
seems like we end up writing into the FILE * structure for stdout. It
seems to be gone if I increase the max_pids by a small number.

Has to be fixed anyway, can you prepare a patch or at least open GitHub
issue so that we can track the problem?

-- 
Cyril Hrubis
chrubis@suse.cz
