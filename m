From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 21 Aug 2017 13:45:22 +0200
Subject: [LTP] [PATCH v4 1/3] lib: add helper SAFE_FANOTIFY_INIT
In-Reply-To: <20170821031216.fv67xdna5eqmjfc2@XZHOUW.usersys.redhat.com>
References: <20170815133616.GD30800@rei>
 <1502867737-26158-1-git-send-email-xzhou@redhat.com>
 <1502867737-26158-2-git-send-email-xzhou@redhat.com>
 <20170818102252.GA22319@rei.lan>
 <20170821031216.fv67xdna5eqmjfc2@XZHOUW.usersys.redhat.com>
Message-ID: <20170821114522.GB3195@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Thanks very much!
> 
> Do you have any tool detecting these warnings ?

Just recent enough gcc (5.4 at this point), there was a quite a lot of
work done on warnings and error message in gcc in the last few years.

-- 
Cyril Hrubis
chrubis@suse.cz
