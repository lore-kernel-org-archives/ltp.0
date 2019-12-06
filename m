From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 6 Dec 2019 16:12:19 +0100
Subject: [LTP] [PATCH v2]syscalls/vmsplice: Add testcase
In-Reply-To: <20191205085803.24636-1-jcronenberg@suse.de>
References: <20191205085803.24636-1-jcronenberg@suse.de>
Message-ID: <20191206151219.GB729@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've changed the code slightly so that we make use of guarded buffers
(the iovec is allocated as a guarded buffer by the test library now) and
pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
