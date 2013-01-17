Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1TvrR8-0005ug-0u
	for ltp-list@lists.sourceforge.net; Thu, 17 Jan 2013 15:31:26 +0000
Date: Thu, 17 Jan 2013 16:31:40 +0100
From: chrubis@suse.cz
Message-ID: <20130117153140.GB12851@rei>
References: <CA+icZUWV1h46fEVYxKr1nd0fGKGsky2JZ4bVas-7yEq3wKcNhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+icZUWV1h46fEVYxKr1nd0fGKGsky2JZ4bVas-7yEq3wKcNhQ@mail.gmail.com>
Subject: Re: [LTP] Mini-Howto: Building ltp-from-git on Ubuntu
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Sedat Dilek <sedat.dilek@gmail.com>
Cc: ltp-list@lists.sourceforge.net


Hi!
> $ cat docs/MINI-HOWTO_BUILDING-LTP-FROM-GIT.txt
> 
> ##### EXPORTS
> 
> export LANG=C
> export LC_ALL=C
> 
> ##### VARIABLES
> 
> GIT_URL="https://github.com/linux-test-project/ltp.git"
> 
> USER="myusername"
> 
> PREFIX="/opt/ltp"
> 
> BUILD_LOG="build-log_ltp-git.txt"
> INSTALL_LOG="install-log_ltp-git.txt"
> 
> ##### PREREQS ON UBUNTU
> 
> sudo apt-get install build-essential
> sudo apt-get install autoconf automake autotools-dev m4
> sudo apt-get install git <--- Optional: git-email for sending patches!
> sudo apt-get install linux-headers-$(uname -r)
> sudo apt-get install libaio-dev

You can add libcap-dev and libattr-dev (and possibly more, we should
probably keep a list in some file in doc/ directory).

> ##### WORKING-DIR
> 
> mkdir -p $HOME/src/ltp
> cd $HOME/src/ltp
> 
> ##### GET LTP SOURCE
> 
> git clone $GIT_URL ltp-git
> 
> ##### CONFIGURING LTP
> 
> cd ltp-git/
> make autotools
> ./configure --prefix=$PREFIX
> 
> ##### BUILDING LTP
> 
> make 2>&1 | tee ../$BUILD_LOG
> 
> ##### INSTALL LTP
> 
> sudo mkdir $PREFIX
> sudo chown $USER:$USER -R $PREFIX
> 
> make install 2>&1 | tee ../$INSTALL_LOG

Hmm, the installation is expected to be run as root (and I'm not sure if
this will work correctly, most of the thigs should, but there may be
test that expects that particular file is owned by root, etc.).

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Master Visual Studio, SharePoint, SQL, ASP.NET, C# 2012, HTML5, CSS,
MVC, Windows 8 Apps, JavaScript and much more. Keep your skills current
with LearnDevNow - 3,200 step-by-step video tutorials by Microsoft
MVPs and experts. ON SALE this month only -- learn more at:
http://p.sf.net/sfu/learnmore_122712
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
