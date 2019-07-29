From: Dave Wysochanski <dwysocha@redhat.com>
Date: Mon, 29 Jul 2019 09:40:57 -0400
Subject: [LTP] [SUNRPC] 661ccd4df3: ltp.proc01.fail
In-Reply-To: <20190729095353.GS22106@shao2-debian>
References: <20190729095353.GS22106@shao2-debian>
Message-ID: <ee309a53cd55517886691c36152044a630da391c.camel@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, 2019-07-29 at 17:53 +0800, kernel test robot wrote:
> FYI, we noticed the following commit (built with gcc-7):
> 
> commit: 661ccd4df38fdcddfeb1f314ac1a1de6c947c3f9 ("[RFC PATCH]
> SUNRPC: Harden the cache 'channel' interface to only allow legitimate
> daemons")
> url: 
> https://github.com/0day-ci/linux/commits/Dave-Wysochanski/SUNRPC-Harden-the-cache-channel-interface-to-only-allow-legitimate-daemons/20190727-042349
> base: git://linux-nfs.org/~bfields/linux.git nfsd-next
> 

This patch is no good and should be NACKd.

Bruce, Neil please consider alternative patch:
[RFC PATCH] SUNRPC: Track writers of the 'channel' file to improve cache_listeners_exist


Thanks.



