From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 8 Jul 2021 13:43:47 +0200
Subject: [LTP] [PATCH v3 0/4] fs_bind: Convert to ltp tests
In-Reply-To: <20210708055757.945702-1-lkml@jv-coder.de>
References: <20210708055757.945702-1-lkml@jv-coder.de>
Message-ID: <YObk85gnpGKFFLSv@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I split up the patch into 4 commits. The first one just renames
> all tests to the new nameing schema, in order to make git detect
> renames instead of delete/add.

Pushed with minor changes, great cleanup, thanks.

I've removed a few trailing whitespaces and also the .gitignore that
should have been included in the last removal patch.


Also I guess that we should move the ns_exec and ns_create tools to the
testcases/lib/ directory so that:

- it's easier to find it

- to make the the how to on running tests from git checkout work
  for these tests as well

-- 
Cyril Hrubis
chrubis@suse.cz
