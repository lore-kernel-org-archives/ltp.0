From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 24 Jan 2020 13:07:03 +0100
Subject: [LTP] [PATCH 2/2] syscalls/vmsplice: Add NONBLOCK testcase
In-Reply-To: <20200124094819.11710-2-jcronenberg@suse.de>
References: <20200124094819.11710-1-jcronenberg@suse.de>
 <20200124094819.11710-2-jcronenberg@suse.de>
Message-ID: <20200124120643.GA31214@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with minor changes, thanks.

* Moved the initial vmsplice() to fill the pipe into the test setup
  otherwise the test breaks on -i parameter

* Added curly braces around multiline if/else blocks
  since this is prefered by LKML see:
  https://www.kernel.org/doc/html/v4.10/process/coding-style.html#placing-braces-and-spaces

* I've put the parent code in the second test out of the else block,
  the child does not return, there is no need to execute the rest of the
  function in an else block

* Put single empty lines between functions, it's much more readable that
  way

Also btw, if you put signed-off-by line after the --- it gets removed,
since everything after --- that is not the actual patch gets ignored, so
the signed-off-by should have been before the block that described the
changes in the commit.

-- 
Cyril Hrubis
chrubis@suse.cz
