From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 3 Jun 2021 08:58:22 +0200
Subject: [LTP] [RFC] Remove disktest from LTP
Message-ID: <YLh9jvI/p/VxsSmx@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

does anybody use testcases/kernel/io/disktest ?

It supports various OS, but not sure if it's relevant now in SSD era.
Last update was in 2008 (version 1.4.2).
It's not in any runtest file thus not being run by default.

I'd either delete it. Or, if still useful, I'd put it into separate project
under https://github.com/linux-test-project.

Kind regards,
Petr
