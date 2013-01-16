Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sedat.dilek@gmail.com>) id 1Tvaah-00045l-8Z
	for ltp-list@lists.sourceforge.net; Wed, 16 Jan 2013 21:32:11 +0000
Received: from mail-qa0-f48.google.com ([209.85.216.48])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Tvaag-0001e6-BN
	for ltp-list@lists.sourceforge.net; Wed, 16 Jan 2013 21:32:11 +0000
Received: by mail-qa0-f48.google.com with SMTP id l8so1581793qaq.0
	for <ltp-list@lists.sourceforge.net>;
	Wed, 16 Jan 2013 13:32:04 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 16 Jan 2013 22:32:04 +0100
Message-ID: <CA+icZUWV1h46fEVYxKr1nd0fGKGsky2JZ4bVas-7yEq3wKcNhQ@mail.gmail.com>
From: Sedat Dilek <sedat.dilek@gmail.com>
Subject: [LTP]  Mini-Howto: Building ltp-from-git on Ubuntu
Reply-To: sedat.dilek@gmail.com
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
To: ltp-list@lists.sourceforge.net

Hi,

this Mini-Howto is a bit distro-specific but may help other users.

Regards,
- Sedat -

$ cat docs/MINI-HOWTO_BUILDING-LTP-FROM-GIT.txt

##### EXPORTS

export LANG=C
export LC_ALL=C

##### VARIABLES

GIT_URL="https://github.com/linux-test-project/ltp.git"

USER="myusername"

PREFIX="/opt/ltp"

BUILD_LOG="build-log_ltp-git.txt"
INSTALL_LOG="install-log_ltp-git.txt"

##### PREREQS ON UBUNTU

sudo apt-get install build-essential
sudo apt-get install autoconf automake autotools-dev m4
sudo apt-get install git <--- Optional: git-email for sending patches!
sudo apt-get install linux-headers-$(uname -r)
sudo apt-get install libaio-dev

##### WORKING-DIR

mkdir -p $HOME/src/ltp
cd $HOME/src/ltp

##### GET LTP SOURCE

git clone $GIT_URL ltp-git

##### CONFIGURING LTP

cd ltp-git/
make autotools
./configure --prefix=$PREFIX

##### BUILDING LTP

make 2>&1 | tee ../$BUILD_LOG

##### INSTALL LTP

sudo mkdir $PREFIX
sudo chown $USER:$USER -R $PREFIX

make install 2>&1 | tee ../$INSTALL_LOG


-dileks // 16-Jan-2013

------------------------------------------------------------------------------
Master Java SE, Java EE, Eclipse, Spring, Hibernate, JavaScript, jQuery
and much more. Keep your Java skills current with LearnJavaNow -
200+ hours of step-by-step video tutorials by Java experts.
SALE $49.99 this month only -- learn more at:
http://p.sf.net/sfu/learnmore_122612 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
