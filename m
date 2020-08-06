From: Martin Doucha <mdoucha@suse.cz>
Date: Thu, 6 Aug 2020 16:31:07 +0200
Subject: [LTP] [PATCH] Add test for CVE-2019-8912
In-Reply-To: <20200806142334.30494-1-mdoucha@suse.cz>
References: <20200806142334.30494-1-mdoucha@suse.cz>
Message-ID: <4b59056f-cad1-b662-f4b3-e8abdee06d30@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 06. 08. 20 16:23, Martin Doucha wrote:
> Fixes #504
> 
> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---

I forgot to mention here that it'd be great to verify this reproducer
using KASAN. The bug should be present in vanilla kernels up until
4.20.10. If you have one of those with KASAN enabled, please check that
af_alg07 will trigger use-after-free error in sockfs_setattr(). Example
KASAN backtrace:
https://patchwork.ozlabs.org/project/netdev/patch/20190215142415.149153-1-maowenan@huawei.com/

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
