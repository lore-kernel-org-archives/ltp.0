From: gregkh <gregkh@linuxfoundation.org>
Date: Thu, 29 Nov 2018 13:36:50 +0100
Subject: [LTP] RFC: changed error code when binding unix socket twice
In-Reply-To: <20181107155644.GA29531@dell5510>
References: <20170630073448.GA9546@unicorn.suse.cz>
 <20180831111436.GA23780@dell5510>
 <CAK8P3a2yfZKMtE16DNCjZBOQ1R5=uXD16k43eJ=najJBh7H85Q@mail.gmail.com>
 <20181029163331.GA31059@dell5510>
 <CAK8P3a1q32spcF445Zhw-KMXG2VwFZuMw5C1sYFk3qLXz3HB5w@mail.gmail.com>
 <20181107155644.GA29531@dell5510>
Message-ID: <20181129123650.GI3149@kroah.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Nov 07, 2018 at 04:56:44PM +0100, Petr Vorel wrote:
> Hi
> 
> > I forgot that 4.1 has ended a while ago. Greg also sometimes still takes patches
> > for 3.18, so that might be a candidate aside from 3.18
> 
> Gregkh, David, does it make sense to you to merge commit 0fb44559ffd6 ("af_unix:
> move unix_mknod() out of bindlock") to 3.18? If yes, please do so.

Now queued up, thanks.

greg k-h
