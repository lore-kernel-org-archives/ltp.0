From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 30 Sep 2019 13:58:50 +0200
Subject: [LTP] [RFC PATCH 0/2] Update user related docs
Message-ID: <20190930115852.21672-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

this is far from being perfect, it's a stub, but better start so one day
it's perfect :).
IMHO the direction should be to have a few high level files with more
content than many files with specific content (that's why merge
colorized-output.txt). doc/user-guide.txt should be added to wiki and
being synced.

See also other patches touching docs [1], [2].

Comments are more then welcome.

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/patch/1166786/
[2] https://patchwork.ozlabs.org/patch/1151766/

Petr Vorel (2):
  doc: Removed outdated ltp-howto.{txt,lyx}
  doc: Add user-guide.txt

 README.md                |   4 +-
 doc/colorized-output.txt |  10 -
 doc/ltp-howto.lyx        | 978 ---------------------------------------
 doc/ltp-howto.txt        | 488 -------------------
 doc/user-guide.txt       |  29 ++
 5 files changed, 32 insertions(+), 1477 deletions(-)
 delete mode 100644 doc/colorized-output.txt
 delete mode 100644 doc/ltp-howto.lyx
 delete mode 100644 doc/ltp-howto.txt
 create mode 100644 doc/user-guide.txt

-- 
2.23.0

