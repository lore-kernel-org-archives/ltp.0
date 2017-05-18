From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 18 May 2017 14:21:10 +0200
Subject: [LTP] [PATCH v3] fanotify: Add test for permission event
	destruction
In-Reply-To: <20170504155433.16736-1-jack@suse.cz>
References: <20170504155433.16736-1-jack@suse.cz>
Message-ID: <20170518122110.GC29477@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with minor changes, thanks.

What I did:

* Updated the copyright year to 2017

* Added the kernel commit ids to the top level comment in the test source

* Removed the fd_notify = -1 after SAFE_CLOSE(fd_notify)
  SAFE_CLOSE() sets the fd to -1 already

* Updated syscalls/.gitignore

-- 
Cyril Hrubis
chrubis@suse.cz
