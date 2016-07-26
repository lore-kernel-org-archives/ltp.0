From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 26 Jul 2016 16:35:54 +0200
Subject: [LTP] [PATCH V3 02/23] Add knob to control tirpc support
In-Reply-To: <20160722042656.22346-2-raj.khem@gmail.com>
References: <20160722042656.22346-1-raj.khem@gmail.com>
 <20160722042656.22346-2-raj.khem@gmail.com>
Message-ID: <20160726143554.GH11679@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> allow to disable tirpc. Helps to disable it at top level for eg. musl it
> does not yet work.

This is the same as the numa one, should be done in the m4/ltp-tirpc.m4

-- 
Cyril Hrubis
chrubis@suse.cz
