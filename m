From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Tue, 2 Jun 2020 13:29:45 +0800
Subject: [LTP] [PATCH] LIB: Use INTERNAL_LIB for ltp lib
In-Reply-To: <20200601142558.GA24805@yuki.lan>
References: <1590730943-23463-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20200601142558.GA24805@yuki.lan>
Message-ID: <c70b9940-dd58-e9f4-9d59-815850775c2e@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril


> Hi!
>> ./lib/libltp.a
> 
> I wonder if we break some third party testsuite by ommitting the
> libltp.a from being installed but I guess that unless anybody objects
> here we do not care that much.
> 
Yes, only at the LTP level, there is no problem without installing these 
libraries.

Best Regards
Yang Xu


