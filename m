From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 6 Nov 2020 16:10:17 +0800
Subject: [LTP] [PATCH v4 1/2] lib: Add generic boolean expression parser
 and eval
In-Reply-To: <20201103161052.13260-2-chrubis@suse.cz>
References: <20201103161052.13260-1-chrubis@suse.cz>
 <20201103161052.13260-2-chrubis@suse.cz>
Message-ID: <5FA504E9.8070308@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2020/11/4 0:10, Cyril Hrubis wrote:
> Add a simple and generic boolean expression parser and evaluator. This
> is a first step in order to implement more complex kconfig expressions,
> but since we are likely to reuse the parser for other purposes in the
> future it's implemented as a generic boolean parser.
>
> Signed-off-by: Cyril Hrubis<chrubis@suse.cz>
Hi Cyril,

LGTM. :-)
Reviewed-by: Xiao Yang <yangx.jy@cn.fujitsu.com>

Best Regards,
Xiao Yang


