From: Joerg Vehlow <lkml@jv-coder.de>
Date: Thu, 24 Jun 2021 11:29:52 +0200
Subject: [LTP] [RFC] fs_bind rework
Message-ID: <fc235ab1-4796-c1d4-d5b0-f1f112c9ce54@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

is there any reason, why the fs_bind suite cannot be reworked into 
"real" ltp tests?
At the moment all tests from the suite are run by the wrapper script.

If I would convert them, I'd try this programmatically, because of the 
huge number of tests.
1. Move stuff from test_fs_bind.sh to a library file
2. Convert all tests in fs_bind/* to ltp tests using the library and 
adding them to the runtest file

This would make every single fs_bind test a single ltp test (~100).
I do not think that runtime increases significantly, because as far as I 
see it from first glance, test_fs_bind.sh resets the "sandbox" used for 
the tests before every test anyway.

If there is no objection, I would give converting the tests a shot.

J?rg
