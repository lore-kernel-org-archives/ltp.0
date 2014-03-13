Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WO4qr-0004Zk-GM
	for ltp-list@lists.sourceforge.net; Thu, 13 Mar 2014 12:35:09 +0000
Date: Thu, 13 Mar 2014 13:34:50 +0100
From: chrubis@suse.cz
Message-ID: <20140313123450.GA27269@rei.suse.cz>
References: <CA+xJJ1_uSNtC88O4AHdVqQXnr0E56VF-EgOZ=OWKDzLyAqaAvg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+xJJ1_uSNtC88O4AHdVqQXnr0E56VF-EgOZ=OWKDzLyAqaAvg@mail.gmail.com>
Subject: Re: [LTP] Versioned files modified by build
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Mats Liljegren <liljegren.mats2@gmail.com>
Cc: Linux Test Project General Discussions <ltp-list@lists.sourceforge.net>

Hi!
> After building in-tree (GIT), I get the following when issuing "git
> status" command:
> 
> # On branch master
> # Changes not staged for commit:
> #   (use "git add <file>..." to update what will be committed)
> #   (use "git checkout -- <file>..." to discard changes in working directory)
> #
> #       modified:   utils/ffsb-6.0-rc2/config.h.in
> #       modified:   utils/ffsb-6.0-rc2/configure
> #
> # Untracked files:
> #   (use "git add <file>..." to include in what will be committed)
> #
> #       testcases/kernel/io/stress_floppy/1000K_file
> #       testcases/kernel/io/stress_floppy/100K_file
> #       testcases/kernel/io/stress_floppy/10K_file
> #       testcases/kernel/io/stress_floppy/dumpdir/
> 
> This would suggest that the files utils/ffsb-6.0-rc2/config.h.in and
> utils/ffsb-6.0-rc2/configure are version controlled. Are they supposed
> to?

The whole ffsb directory is just untared archive of the ffsb benchmark
which is needed to produce the ffsb binary which is used in a few tests.

I cannot reproduce the diff in ffsb but I remeber seeing it. I think
that it's safe to ignore this one.

> Should above untracked files be added to .gitignore?

Looking at the stress_floppy Makefile these files are created upon
install phase, which is likely the reason these are missing from
.gitignore files. Feel free to send a patch.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
