From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Mon, 20 Nov 2017 10:09:03 +0100
Subject: [LTP] [PATCH] syscalls/add_key04: new test for associative
	array bug
In-Reply-To: <20171108211123.94429-1-ebiggers3@gmail.com>
References: <20171108211123.94429-1-ebiggers3@gmail.com>
Message-ID: <87shd9iafk.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


Hello,

This looks good to me, except for some nit picking: sprintf could be
snprintf and probably you only need one 'associative'. However I would
be happy for this to be merged as-is.

-- 
Thank you,
Richard.
