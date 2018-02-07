From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 7 Feb 2018 17:03:57 +0300
Subject: [LTP] Errored: linux-test-project/ltp#644 (master - 9db796a)
In-Reply-To: <5a7b025a7e3ab_43fea05328f50611979@d5906623-1f8e-4f3a-bb12-16f6bf1232a2.mail>
References: <5a7b025a7e3ab_43fea05328f50611979@d5906623-1f8e-4f3a-bb12-16f6bf1232a2.mail>
Message-ID: <08005f3a-c706-9961-dcf4-ce28e9d2b4ee@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 07.02.2018 16:42, Travis CI wrote:
> *linux-test-project / ltp <https://travis-ci.org/linux-test-project/ltp?utm_source=email&utm_medium=notification>* (master <https://github.com/linux-test-project/ltp/tree/master>)
> 
> 	Build #644 has errored. <https://travis-ci.org/linux-test-project/ltp/builds/338496644?utm_source=email&utm_medium=notification> 	
> 16 minutes and 51 seconds
One of the build failed on gcc7 installation:

$ sudo -E apt-get -yq --no-install-suggests --no-install-recommends --force-yes install gcc-7
  E: Unable to locate package gcc-7

Thanks,
Alexey
