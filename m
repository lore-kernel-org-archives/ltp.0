From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 29 Jan 2020 04:11:19 -0500 (EST)
Subject: [LTP] [PATCH] read_all: skip eeprom and nvmem
In-Reply-To: <20200128213033.GA23147@dell5510>
References: <79fee43729701f3a3d46c6cbc26fa3f2402e182e.1579877705.git.jstancek@redhat.com>
 <20200128213033.GA23147@dell5510>
Message-ID: <1864416055.4725286.1580289079295.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> Hi Jan,
> 
> > Big Power9 NV systems are failing to complete the test, as they
> > spend lot of time on /sys/devices/platform, trying to read dozens
> > of low level files like eeprom or nvmem. Each adds couple seconds,
> > eventually pushing test over timeout.
> 
> > User or system admin is unlikely to ever need to access these
> > entries, so skip them.
> LGTM.
> Acked-by: Petr Vorel <pvorel@suse.cz>

Thanks, pushed.

