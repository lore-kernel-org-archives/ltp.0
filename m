From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 14 May 2021 11:14:31 +0200
Subject: [LTP] [PATCH 1/2] build.sh: Support passing configure options
In-Reply-To: <YJ4p7636z0iYSsy0@yuki>
References: <20210512165702.22883-1-pvorel@suse.cz>
 <YJ4p7636z0iYSsy0@yuki>
Message-ID: <YJ4/d4pTsWNRYX02@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> Hi!
> Looks good, but is it even used for the second patch? We just pass extra
> options there, right?
Yes, CONFIGURE_OPT_EXTRA. I added also CONFIGURE_OPT to allow local build.sh
without realtime and openposix: 
$ CONFIGURE_OPT= ./build.sh

I document it in the commit.

Kind regards,
Petr
