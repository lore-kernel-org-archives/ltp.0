From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 12 Feb 2021 14:23:06 +0100
Subject: [LTP] [PATCH v2 5/5] close_range: Add test
In-Reply-To: <20210211174543.25003-6-rpalethorpe@suse.com>
References: <20210211174543.25003-1-rpalethorpe@suse.com>
 <20210211174543.25003-6-rpalethorpe@suse.com>
Message-ID: <YCaBOqMhTqNlRhH5@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with small changes, thanks.

* Added a runtest file entry

* Add .needs_root which is what we have for tests that utilize loop devices

* Reformatted the top level comment so it's picked by docparser

* Shortened the git hash to 12 characters, since that's what we have in
  the rest of the tests


Also we are missing simple test for a negative cases, that is:

* Check that EINVAL is returned if we pass ~0 to flags

* And check that EINVAL is returned when fd < fd_max as well


And one more a bit more complicated test:

We should also get EMFILE if we do CLOSE_RANGE_UNSHARE and the parent
rlimit is exhausted.


Will you write these tests as well, or should I have a look?

-- 
Cyril Hrubis
chrubis@suse.cz
