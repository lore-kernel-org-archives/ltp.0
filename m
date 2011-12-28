Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1RfkZY-0000nc-0X
	for ltp-list@lists.sourceforge.net; Wed, 28 Dec 2011 03:53:00 +0000
Received: from mail-gx0-f175.google.com ([209.85.161.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1RfkZX-0000Wy-9O
	for ltp-list@lists.sourceforge.net; Wed, 28 Dec 2011 03:52:59 +0000
Received: by ggnh1 with SMTP id h1so10465546ggn.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 27 Dec 2011 19:52:53 -0800 (PST)
Message-ID: <4EFA8B41.1040802@casparzhang.com>
Date: Wed, 28 Dec 2011 11:21:37 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <1324872283-6292-1-git-send-email-eguan@redhat.com>
In-Reply-To: <1324872283-6292-1-git-send-email-eguan@redhat.com>
Subject: Re: [LTP] [PATCH 1/2 V2] syscalls/setxattr01: new testcase to test
 setxattr(2) basic function
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Eryu Guan <eguan@redhat.com>
Cc: ltp-list@lists.sourceforge.net

On 12/26/2011 12:04 PM, Eryu Guan wrote:
> +			tname = tc[i].fname;
> +			tkey = tc[i].key;
> +			tvalue = tc[i].value;
> +			tsize = tc[i].size;
> +			tflags = tc[i].flags;
> +			texp_err = tc[i].exp_err;
> +
> +			TEST(setxattr(tname, tkey, tvalue, tsize, tflags));

I wonder whether it's necessary. all of the variables be used once only.

Others looks good for me.

Caspar

------------------------------------------------------------------------------
Write once. Port to many.
Get the SDK and tools to simplify cross-platform app development. Create 
new or port existing apps to sell to consumers worldwide. Explore the 
Intel AppUpSM program developer opportunity. appdeveloper.intel.com/join
http://p.sf.net/sfu/intel-appdev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
