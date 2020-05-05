From: Martin Doucha <mdoucha@suse.cz>
Date: Tue, 5 May 2020 16:33:19 +0200
Subject: [LTP] [PATCH 1/2] Add test for CVE 2016-8655
In-Reply-To: <20200505131724.GA21884@dell5510>
References: <20200505102456.13004-1-mdoucha@suse.cz>
 <20200505131724.GA21884@dell5510>
Message-ID: <cdd26392-10a9-b952-361d-8308585c3980@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 05. 05. 20 15:17, Petr Vorel wrote:
> I wanted to propose after release dropping gcc 4 support by deleting CentOS 6
> from Travis (but maybe we should drop it even now). To keep the support, it'd be
> good to add lapi/if_packet.h with this definition.

I don't really care about CentOS 6 either way but I'll add the new LAPI
header and resubmit.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
