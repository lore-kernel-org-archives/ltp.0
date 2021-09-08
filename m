From: Martin Doucha <mdoucha@suse.cz>
Date: Wed, 8 Sep 2021 15:54:31 +0200
Subject: [LTP] [PATCH] lib: memutils: don't pollute entire system memory
 to avoid OoM
In-Reply-To: <YTi8qQOZU3NriZvZ@yuki>
References: <20210624132226.84611-1-krzysztof.kozlowski@canonical.com>
 <YTi8qQOZU3NriZvZ@yuki>
Message-ID: <3308f9e1-7766-8409-0360-9fe798276a90@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 08. 09. 21 15:37, Cyril Hrubis wrote:
> Hi!
> I guess that this is another bug that should be fixed before the
> release. I still think that the memory pollution is a best effort
> operation and that we should be more conservative with the reserve. I
> would go for a few percents of the free memory just to be extra sure
> that we do not cause memory pressure.
> 
> If we go for 2% we will add following;
> 
> safety = MAX(safety, info.freeram / 50);
> 
> Also it looks like info.freeram is the same as MemFree: from
> /proc/meminfo, I guess that this is not wrong, since memory that have
> been used in buffers is dirty enough for our case.

I'd recommend dividing by a power of 2 (either 32 or 64) but other than
that, I completely agree.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
