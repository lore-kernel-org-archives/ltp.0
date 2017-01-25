From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 25 Jan 2017 16:40:59 +0300
Subject: [LTP] [PATCH v2 2/2] net: traceroute01: use latest net API and
 add IPv6 version
In-Reply-To: <20170124102014.GD27769@rei.lan>
References: <1484914006-23396-1-git-send-email-alexey.kodanev@oracle.com>
 <1484914006-23396-2-git-send-email-alexey.kodanev@oracle.com>
 <20170124102014.GD27769@rei.lan>
Message-ID: <a19c4f30-1c49-2861-988d-85cfbf0ad5b7@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Changed it slightly and applied:
* use sizes from traceroute man page, what is default for IPv4 and IPv6
* add TCP SYN probe test

Thanks,
Alexey

