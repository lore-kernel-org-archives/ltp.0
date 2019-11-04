From: Martin Doucha <mdoucha@suse.cz>
Date: Mon, 4 Nov 2019 16:51:42 +0100
Subject: [LTP] [PATCH 1/1] Fix compression ratio calculation in zram01
In-Reply-To: <20191104151647.GA15477@dell5510>
References: <20191104125228.17173-1-mdoucha@suse.cz>
 <20191104125228.17173-2-mdoucha@suse.cz> <20191104151647.GA15477@dell5510>
Message-ID: <7c68a69d-8edd-d4d5-de1d-39d2cb8e4f03@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 11/4/19 4:16 PM, Petr Vorel wrote:
> I wonder if /sys/block/zram0/mm_stat is missing whether it can be on any other
> zram<id>. Is it it's presence file system specific? Shouldn't we just quit whole
> test wit tst_brk TCONF.

If /sys/block/zram0/mm_stat is missing then all /sys/block/zram*/mm_stat
files should be missing. But I don't want to terminate the test there
because the remaining 3 write tests could still find a regression. So
print a TCONF message on the first pass and silently skip the remaining
compression ratio checks.

I was also thinking about checking whether the write test filled the
test file at least up to 50% of memory limit if mm_stat doesn't exist.
But it'd mostly add unnecessary complexity.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
