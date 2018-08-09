From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 9 Aug 2018 11:04:07 +0200
Subject: [LTP] [PATCH v2] syscalls/execveat01: new test to verify
 execveat unlinked fd
In-Reply-To: <1533111474.1176.4.camel@mtkswgap22>
References: <1533111474.1176.4.camel@mtkswgap22>
Message-ID: <20180809090406.GA29365@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with minor changes, thanks.

* Added check for execveat() support to the test setup and dropped the
  minimal kernel version from test structure

* Renamed the test to execveat03 so that we can add execveat01 and
  execveat02 that would test the cases without overlay being involved

* Removed SAFE_WAITPID() from the verify_execveat() since the child
  has to be waited for in the test library so that errors are propagated
  correctly

* Moved the execveat.h to the include/lapi/ directory

* Added syscalls/runtest entry so that the test is executed during the
  tesrun

-- 
Cyril Hrubis
chrubis@suse.cz
