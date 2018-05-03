From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 3 May 2018 15:31:44 +0200
Subject: [LTP] [PATCH] setregid: use common user and group names.
In-Reply-To: <20180319200113.106692-1-sspatil@google.com>
References: <20180319200113.106692-1-sspatil@google.com>
Message-ID: <20180503133144.GB27716@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
FIY this seems cause failures on Debian 9 where I do get failures:

setregid03    1  TBROK  :  setregid03.c:198: nobody must be a valid group
setregid03    2  TBROK  :  setregid03.c:198: Remaining cases broken

setregid04    1  TBROK  :  setregid04.c:126: Couldn't find the `nobody' group
setregid04    2  TBROK  :  setregid04.c:126: Remaining cases broken

I guess that we need a fallback if nobody group does not exist.

-- 
Cyril Hrubis
chrubis@suse.cz
