From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 27 Mar 2018 15:01:31 +0200
Subject: [LTP] [PATCH v6 0/3] Add regression test for CVE-2017-17053
In-Reply-To: <5ABA136A.8080609@cn.fujitsu.com>
References: <20180309124418.30271-1-mmoese@suse.de>
 <5AB35983.6060900@cn.fujitsu.com> <5ABA136A.8080609@cn.fujitsu.com>
Message-ID: <20180327130131.GA28115@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
As Michael said there is not much we can do in LTP here, the test cannot
be executed because kernel is already tainted. The best solution is to
fix the kernel not to spew warnings but I know that it's not as easy as
it sounds.

-- 
Cyril Hrubis
chrubis@suse.cz
