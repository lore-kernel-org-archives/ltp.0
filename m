From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 10 Nov 2016 09:22:56 +0100
Subject: [LTP] [PATCH 0/3] network: updated doc
Message-ID: <20161110082259.32348-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi there,

sending patches to update doc related mainly to network scripts. There is
duplicity with testcases/network/README.md, it might be good to keep info only one place.
Also fixed runalltests.sh (although network tests aren't running atm).

Kind regards,
Petr

Petr Vorel (3):
  doc: update networking related documentation
  doc: replace ltp.cvs.sourceforge.net links by path
  runalltests.sh: update network related scripts paths

 INSTALL                          | 25 ++++++++++---------------
 doc/ltp-run-files.txt            |  2 +-
 runalltests.sh                   | 21 ++++++++++-----------
 testcases/kernel/fs/fs_bind/TODO |  2 --
 4 files changed, 21 insertions(+), 29 deletions(-)

-- 
2.10.2

