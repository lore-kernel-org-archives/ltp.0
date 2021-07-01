From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Thu, 01 Jul 2021 11:21:03 +0100
Subject: [LTP] [PATCH v2] Add documentation for netdevice and rtnetlink
 libraries
In-Reply-To: <20210630154611.12019-1-mdoucha@suse.cz>
References: <20210630154611.12019-1-mdoucha@suse.cz>
Message-ID: <87czs22v3k.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Martin,

Martin Doucha <mdoucha@suse.cz> writes:

> Signed-off-by: Martin Doucha <mdoucha@suse.cz>

Acked-by: Richard Palethorpe <rpalethorpe@suse.com>

> ---
>
> Changes since v1:
> - Refer to tst_brk() instead of explaining test termination on error
> - Use ndash where appropriate
> - Improved formatting of warnings
>
> We can't change struct tst_rtnl_attr_list.type to an enum. We don't have
> the complete list of its values and it has to match struct rtattr.rta_type,
> which is defined as unsigned short by the kernel.

+1

-- 
Thank you,
Richard.
