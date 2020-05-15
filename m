From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 15 May 2020 11:32:12 +0200
Subject: [LTP] [PATCH v4 0/4] Update installation docs
Message-ID: <20200515093216.829-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

changes v3->v4:
* improve note about other library dependencies in 1st commit (Jan)
* remove also "What's in a Path?" in 3rd commit

It'd need more cleanup, but enough now :).

Kind regards,
Petr

Petr Vorel (4):
  INSTALL: Update requirements, modernise text
  INSTALL: Document 32bit and cross-compilation setup
  INSTALL: Remove uClinux and "What's in a Path?" sections
  doc: Remove links to README.mk-devel

 INSTALL                 | 88 ++++++++++++++++-------------------------
 README.md               |  5 ++-
 include/mk/config.mk.in |  2 +-
 3 files changed, 38 insertions(+), 57 deletions(-)

-- 
2.26.2

