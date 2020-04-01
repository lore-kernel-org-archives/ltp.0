From: Martin Doucha <mdoucha@suse.cz>
Date: Wed, 1 Apr 2020 11:55:11 +0200
Subject: [LTP] LTP compilation broken with -fno-common
In-Reply-To: <20200401093934.GA23773@yuki.lan>
References: <20200401083228.GA18685@dell5510> <20200401093934.GA23773@yuki.lan>
Message-ID: <e9ea8c2a-7c00-26a7-fb1a-0db9ae093620@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 01. 04. 20 11:39, Cyril Hrubis wrote:
> We cannot move that definition into tst_test.c beacuse that would mean
> that old API test would end up with multiple definitions one in the
> corresponding test and one in the new library library code.

But we can move it a few lines up in tst_main.h so that it gets defined
only together with the default main(), not in every .c file that
includes tst_test.h.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
