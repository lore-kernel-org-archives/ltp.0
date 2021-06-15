From: Martin Doucha <mdoucha@suse.cz>
Date: Tue, 15 Jun 2021 13:32:03 +0200
Subject: [LTP] [PATCH] icmp_rate_limit01: Require CONFIG_VETH
In-Reply-To: <20210615075104.24870-1-rpalethorpe@suse.com>
References: <20210615075104.24870-1-rpalethorpe@suse.com>
Message-ID: <6867b219-5591-ec12-47a7-e9f0b525a76e@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
looks good.

Reviewed-by: Martin Doucha <mdoucha@suse.cz>

On 15. 06. 21 9:51, Richard Palethorpe wrote:
> The test fails with TBROK if it can not create a virtual ethernet
> pair. So add it to the kconfigs.
> 
> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> ---
> 
> Just thinking about the config meta data and embedded users. Functions
> like tst_create_veth_pair could check needs_kconfigs for the required
> config and TBROK if it is not there.
> 
> Alternatively (or in addition to) static analyses can be used to check
> (or add) missing config.
> 
> In either case this may be wrong when a function is only used in a
> branch. OTOH then the test needs splitting otherwise the metadata
> can't be known ahead of execution.

I'll mention the need to check CONFIG_VETH in the docs.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
