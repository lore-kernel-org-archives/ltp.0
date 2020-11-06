From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 6 Nov 2020 16:09:54 +0800
Subject: [LTP] [PATCH v4 2/2] lib/tst_kconfig: Make use of boolean
 expression eval
In-Reply-To: <20201103161052.13260-3-chrubis@suse.cz>
References: <20201103161052.13260-1-chrubis@suse.cz>
 <20201103161052.13260-3-chrubis@suse.cz>
Message-ID: <5FA504D2.7040202@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2020/11/4 0:10, Cyril Hrubis wrote:
> Now each string in the kconfig[] array in tst_test structure is an
> boolean expression which is evaluated. All expressions has to be true in
> order for the test to continue.
>
> This also makes the parser for the kernel config a bit more robust as it
> was pointed out that there may have been cases where it could be mislead
> by hand edited config files.
>
> + Update the docs.
>
> Signed-off-by: Cyril Hrubis<chrubis@suse.cz>
> CC: Pengfei Xu<pengfei.xu@intel.com>
Hi Cyril,

LGTM. :-)
Reviewed-by: Xiao Yang <yangx.jy@cn.fujitsu.com>

Best Regards,
Xiao Yang


