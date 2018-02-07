From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 7 Feb 2018 15:11:27 +0100
Subject: [LTP] Errored: linux-test-project/ltp#644 (master - 9db796a)
In-Reply-To: <08005f3a-c706-9961-dcf4-ce28e9d2b4ee@oracle.com>
References: <5a7b025a7e3ab_43fea05328f50611979@d5906623-1f8e-4f3a-bb12-16f6bf1232a2.mail>
 <08005f3a-c706-9961-dcf4-ce28e9d2b4ee@oracle.com>
Message-ID: <20180207141126.GA31084@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > *linux-test-project / ltp <https://travis-ci.org/linux-test-project/ltp?utm_source=email&utm_medium=notification>* (master <https://github.com/linux-test-project/ltp/tree/master>)
> > 
> > 	Build #644 has errored. <https://travis-ci.org/linux-test-project/ltp/builds/338496644?utm_source=email&utm_medium=notification> 	
> > 16 minutes and 51 seconds
> One of the build failed on gcc7 installation:
> 
> $ sudo -E apt-get -yq --no-install-suggests --no-install-recommends --force-yes install gcc-7
>   E: Unable to locate package gcc-7

It seem to happen randomly, AFAIC Peter opened github issue for travis
for this.

-- 
Cyril Hrubis
chrubis@suse.cz
