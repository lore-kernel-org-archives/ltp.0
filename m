From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 1 Sep 2021 19:55:00 +0200
Subject: [LTP] [PATCH v3 1/2] controllers/cpuacct: skip cpuacct_100_100
 on small memory systems
In-Reply-To: <440b0bcf-63b5-bb78-6a0b-565a5266d9da@canonical.com>
References: <20210827092007.20889-1-krzysztof.kozlowski@canonical.com>
 <YS99h3rPMLeSEFv5@yuki>
 <440b0bcf-63b5-bb78-6a0b-565a5266d9da@canonical.com>
Message-ID: <YS++dM4sC2Do8rDM@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I'll move this piece, as you suggested. The free memory limits is okay
> to stay here?

There is no such API in the C library yet, so unless you want to add it
it can stay where it is.

-- 
Cyril Hrubis
chrubis@suse.cz
