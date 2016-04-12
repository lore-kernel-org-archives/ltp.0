From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 12 Apr 2016 15:07:58 +0200
Subject: [LTP] [PATCH v2] max_map_count: fix error by using runtime check
In-Reply-To: <570CA0AE.6020804@huawei.com>
References: <56DD6138.9060109@huawei.com> <20160322102943.GA10195@rei.suse.cz>
 <56F14D59.1040701@huawei.com> <20160322142842.GE10905@rei.suse.cz>
 <56F259A7.1080908@huawei.com>
 <1242994016.13404335.1458728559657.JavaMail.zimbra@redhat.com>
 <20160331120726.GB21298@rei.lan> <5703A5C6.3000102@huawei.com>
 <20160411170358.GB3466@rei.lan> <570CA0AE.6020804@huawei.com>
Message-ID: <20160412130757.GA2875@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> There is a error when compile the case to 32bit binary and
> run it on 64bit arm kernel, which will wrongly skip one mapping.

Pushed with fixed typo in the patch description, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
