From: =?unknown-8bit?q?K=C3=B6ry?= Maincent <kory.maincent@bootlin.com>
Date: Mon, 30 Nov 2020 20:33:24 +0100
Subject: [LTP] Make FTP test compatible with Busybox and Dropbear.
Message-ID: <20201130203324.613c1b08@kmaincent-XPS-13-7390>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

I am working with LTP on an embedded board.
I would like to notice the rhost_run command does not work with Dropbear ssh
client. I am trying to understand how tst_net work but I am a bit struggling
with it. What is the usage of TST_USE_NETNS, and the purpose of netspace (it
seems to be used to configure a virtual interface)?
My aim was to make FTP test work with Dropbear and Busybox. If someone could
point me out how to do it.

Regards,

K?ry

