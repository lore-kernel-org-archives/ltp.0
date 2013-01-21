Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1TxHKe-00060i-72
	for ltp-list@lists.sourceforge.net; Mon, 21 Jan 2013 13:22:36 +0000
Date: Mon, 21 Jan 2013 14:22:54 +0100
From: chrubis@suse.cz
Message-ID: <20130121132254.GB3768@rei>
References: <CA+icZUWV1h46fEVYxKr1nd0fGKGsky2JZ4bVas-7yEq3wKcNhQ@mail.gmail.com>
	<20130117153140.GB12851@rei>
	<CA+icZUUQ4tGuko9qjMcaSUFCBaforJprCKgMMbbJpsPdKVPp6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+icZUUQ4tGuko9qjMcaSUFCBaforJprCKgMMbbJpsPdKVPp6Q@mail.gmail.com>
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
> ##### EXPORTS
> 
> export LANG=C
> export LC_ALL=C
> 
> ##### VARIABLES
> 
> WORKING_DIR="$HOME/src/ltp"
> 
> BUILD_LOG_FILE="build-log_ltp-git.txt"
> INSTALL_LOG_FILE="install-log_ltp-git.txt"
> 
> GIT_URL="https://github.com/linux-test-project/ltp.git"
> 
> PREFIX="/opt/ltp"
> 
> ##### PREREQS ON UBUNTU
> 
> sudo apt-get install build-essential
> sudo apt-get install autoconf automake autotools-dev m4
> sudo apt-get install git
> sudo apt-get install linux-headers-$(uname -r)
> sudo apt-get install libaio-dev libattr1-dev libcap-dev
> 
> ##### WORKING-DIR
> 
> mkdir -p $WORKING_DIR
> cd $WORKING_DIR
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
> make 2>&1 | tee ../$BUILD_LOG_FILE
> 
> ##### INSTALL LTP
> 
> sudo make install 2>&1 | tee ../$INSTALL_LOG_FILE


This one looks good. I think that we can add it into the doc/ directory,
can you send a patch? (and perhaps change the filename not to use caps
as the rest of the files in doc/ is named in lowercase letters).

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Master Visual Studio, SharePoint, SQL, ASP.NET, C# 2012, HTML5, CSS,
MVC, Windows 8 Apps, JavaScript and much more. Keep your skills current
with LearnDevNow - 3,200 step-by-step video tutorials by Microsoft
MVPs and experts. SALE $99.99 this month only -- learn more at:
http://p.sf.net/sfu/learnmore_122412
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
